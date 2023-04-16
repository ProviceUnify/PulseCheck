--select * from AspNetUsers
--INSERT INTO AspNetUserClaims (UserId, ClaimType, ClaimValue) VALUES ('d27dbb5e-3f3a-4f29-8b4f-f409e98b79c9', 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role', 'promoted')
delete top (1) from AspNetUserClaims
select * from AspNetUserClaims