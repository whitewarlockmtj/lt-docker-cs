using app.domains.users;
using Microsoft.EntityFrameworkCore;

namespace app.infra
{
    public class PostgresDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }

        public PostgresDbContext(DbContextOptions<PostgresDbContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().ToTable("users");
        }
    }
}