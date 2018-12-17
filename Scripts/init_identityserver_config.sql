SET IDENTITY_INSERT [dbo].[ApiResources] ON 
GO
INSERT [dbo].[ApiResources] ([Id], [Enabled], [Name], [DisplayName], [Description], [Created], [Updated], [LastAccessed], [NonEditable]) VALUES (1, 1, N'IdentityServerSample.API', N'Sample Api Resource', N'Sample Api Access', CAST(N'2018-12-16T22:29:43.7626674' AS DateTime2), NULL, NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[ApiResources] OFF
GO
SET IDENTITY_INSERT [dbo].[ApiClaims] ON 
GO
INSERT [dbo].[ApiClaims] ([Id], [Type], [ApiResourceId]) VALUES (1, N'name', 1)
GO
SET IDENTITY_INSERT [dbo].[ApiClaims] OFF
GO
SET IDENTITY_INSERT [dbo].[ApiScopes] ON 
GO
INSERT [dbo].[ApiScopes] ([Id], [Name], [DisplayName], [Description], [Required], [Emphasize], [ShowInDiscoveryDocument], [ApiResourceId]) VALUES (1, N'api', N'Sample API Access', NULL, 0, 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[ApiScopes] OFF
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 
GO
INSERT [dbo].[Clients] ([Id], [Enabled], [ClientId], [ProtocolType], [RequireClientSecret], [ClientName], [Description], [ClientUri], [LogoUri], [RequireConsent], [AllowRememberConsent], [AlwaysIncludeUserClaimsInIdToken], [RequirePkce], [AllowPlainTextPkce], [AllowAccessTokensViaBrowser], [FrontChannelLogoutUri], [FrontChannelLogoutSessionRequired], [BackChannelLogoutUri], [BackChannelLogoutSessionRequired], [AllowOfflineAccess], [IdentityTokenLifetime], [AccessTokenLifetime], [AuthorizationCodeLifetime], [ConsentLifetime], [AbsoluteRefreshTokenLifetime], [SlidingRefreshTokenLifetime], [RefreshTokenUsage], [UpdateAccessTokenClaimsOnRefresh], [RefreshTokenExpiration], [AccessTokenType], [EnableLocalLogin], [IncludeJwtId], [AlwaysSendClientClaims], [ClientClaimsPrefix], [PairWiseSubjectSalt], [Created], [Updated], [LastAccessed], [UserSsoLifetime], [UserCodeType], [DeviceCodeLifetime], [NonEditable]) VALUES (1, 1, N'implicit', N'oidc', 1, N'IdentityServer Demo Client', NULL, NULL, NULL, 1, 1, 1, 0, 0, 1, NULL, 1, NULL, 1, 0, 300, 3600, 300, NULL, 2592000, 1296000, 1, 0, 1, 0, 1, 0, 0, N'client_', NULL, CAST(N'2018-12-16T22:29:43.0382866' AS DateTime2), NULL, NULL, NULL, NULL, 300, 0)
GO
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientGrantTypes] ON 
GO
INSERT [dbo].[ClientGrantTypes] ([Id], [GrantType], [ClientId]) VALUES (1, N'implicit', 1)
GO
SET IDENTITY_INSERT [dbo].[ClientGrantTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientPostLogoutRedirectUris] ON 
GO
INSERT [dbo].[ClientPostLogoutRedirectUris] ([Id], [PostLogoutRedirectUri], [ClientId]) VALUES (1, N'http://localhost:4200/index.html', 1)
GO
SET IDENTITY_INSERT [dbo].[ClientPostLogoutRedirectUris] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientRedirectUris] ON 
GO
INSERT [dbo].[ClientRedirectUris] ([Id], [RedirectUri], [ClientId]) VALUES (1, N'http://localhost:4200/index.html', 1)
GO
INSERT [dbo].[ClientRedirectUris] ([Id], [RedirectUri], [ClientId]) VALUES (2, N'http://localhost:4200/silent-refresh.html', 1)
GO
SET IDENTITY_INSERT [dbo].[ClientRedirectUris] OFF
GO
SET IDENTITY_INSERT [dbo].[ClientScopes] ON 
GO
INSERT [dbo].[ClientScopes] ([Id], [Scope], [ClientId]) VALUES (1, N'openid', 1)
GO
INSERT [dbo].[ClientScopes] ([Id], [Scope], [ClientId]) VALUES (2, N'profile', 1)
GO
INSERT [dbo].[ClientScopes] ([Id], [Scope], [ClientId]) VALUES (3, N'email', 1)
GO
INSERT [dbo].[ClientScopes] ([Id], [Scope], [ClientId]) VALUES (4, N'api', 1)
GO
SET IDENTITY_INSERT [dbo].[ClientScopes] OFF
GO
SET IDENTITY_INSERT [dbo].[IdentityResources] ON 
GO
INSERT [dbo].[IdentityResources] ([Id], [Enabled], [Name], [DisplayName], [Description], [Required], [Emphasize], [ShowInDiscoveryDocument], [Created], [Updated], [NonEditable]) VALUES (1, 1, N'openid', N'Your user identifier', NULL, 1, 0, 1, CAST(N'2018-12-16T22:29:43.5113762' AS DateTime2), NULL, 0)
GO
INSERT [dbo].[IdentityResources] ([Id], [Enabled], [Name], [DisplayName], [Description], [Required], [Emphasize], [ShowInDiscoveryDocument], [Created], [Updated], [NonEditable]) VALUES (2, 1, N'email', N'Your email address', NULL, 0, 1, 1, CAST(N'2018-12-16T22:29:43.5523071' AS DateTime2), NULL, 0)
GO
INSERT [dbo].[IdentityResources] ([Id], [Enabled], [Name], [DisplayName], [Description], [Required], [Emphasize], [ShowInDiscoveryDocument], [Created], [Updated], [NonEditable]) VALUES (3, 1, N'profile', N'User profile', N'Your user profile information (first name, last name, etc.)', 0, 1, 1, CAST(N'2018-12-16T22:29:43.5645233' AS DateTime2), NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[IdentityResources] OFF
GO
SET IDENTITY_INSERT [dbo].[IdentityClaims] ON 
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (1, N'sub', 1)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (2, N'zoneinfo', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (3, N'birthdate', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (4, N'gender', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (5, N'website', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (6, N'picture', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (7, N'profile', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (8, N'locale', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (9, N'preferred_username', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (10, N'middle_name', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (11, N'given_name', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (12, N'family_name', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (13, N'name', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (14, N'email_verified', 2)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (15, N'email', 2)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (16, N'nickname', 3)
GO
INSERT [dbo].[IdentityClaims] ([Id], [Type], [IdentityResourceId]) VALUES (17, N'updated_at', 3)
GO
SET IDENTITY_INSERT [dbo].[IdentityClaims] OFF
GO
INSERT [dbo].[PersistedGrants] ([Key], [Type], [SubjectId], [ClientId], [CreationTime], [Expiration], [Data]) VALUES (N't+jJZnyO506arDgH6P0IEjSN2VLkG4J+XePW6l+Ah+Q=', N'user_consent', N'b5dcd8e7-512a-472e-b7a8-67784a2b775c', N'implicit', CAST(N'2018-12-16T22:57:02.0000000' AS DateTime2), NULL, N'{"SubjectId":"b5dcd8e7-512a-472e-b7a8-67784a2b775c","ClientId":"implicit","Scopes":["openid","profile","email","api"],"CreationTime":"2018-12-16T22:57:02Z","Expiration":null}')
GO
