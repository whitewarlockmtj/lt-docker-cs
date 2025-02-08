namespace app.controllers.dtos
{
    /// <summary>
    /// Represents the response structure for a list of users.
    /// </summary>
    public class UserListResponse
    {
        /// <summary>
        /// The list of users.
        /// </summary>
        public List<UserResponse> Data { get; set; } = new List<UserResponse>();
    }
}