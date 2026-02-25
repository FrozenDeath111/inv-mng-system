<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\JsonResponse;
use Laravel\Passport\Bridge\UserRepository;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use League\OAuth2\Server\AuthorizationServer;
use League\OAuth2\Server\Grant\PasswordGrant;
use Laravel\Passport\Bridge\RefreshTokenRepository;
use Laravel\Passport\Http\Controllers\AccessTokenController;


class TokenController extends AccessTokenController
{
     public function issueToken(ServerRequestInterface $request, ResponseInterface $response): JsonResponse
     {
          try {
               $body = (array) ($request->getParsedBody() ?? []);
               $remember = filter_var($body['remember'] ?? false, FILTER_VALIDATE_BOOLEAN);

               $accessTtlMinutes = (int) env('ACCESS_TOKEN_EXPIRY_MINUTES', 15);
               $refreshTtlMinutes = $remember
                    ? (int) env('REMEMBER_ME_TOKEN_EXPIRY_DAYS', 30) * 24 * 60
                    : (int) env('REFRESH_TOKEN_EXPIRY_MINUTES', 120);

               $accessInterval = new \DateInterval('PT' . max(1, $accessTtlMinutes) . 'M');
               $refreshInterval = new \DateInterval('PT' . max(1, $refreshTtlMinutes) . 'M');

               // Reconfigure the AuthorizationServer with per-request TTLs
               /** @var AuthorizationServer $server */
               $server = app(AuthorizationServer::class);

               // Create a fresh PasswordGrant wired to Passport’s repositories
               $passwordGrant = new PasswordGrant(
                    app(UserRepository::class),
                    app(RefreshTokenRepository::class)
               );
               $passwordGrant->setRefreshTokenTTL($refreshInterval);

               // IMPORTANT: enable the grant with your *access token* TTL
               $server->enableGrantType($passwordGrant, $accessInterval);

               $response = parent::issueToken($request, $response);
               $result = json_decode($response->getContent(), true);

               $response = [
                    'data' => $result,
                    'message' => 'Token generated successfully',
                    'status' => 'success',
                    'code' => 200
               ];
               return response()->json($response, 200);
          } catch (Exception $e) {
               return response()->json([
                    'message' => 'Token generation failed',
                    'status' => 'error',
                    'code' => 401
               ], 401);
          }
     }
}
