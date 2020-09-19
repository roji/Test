using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;

namespace Test.Pages
{
    public class IndexModel : PageModel
    {
        private UserManager<IdentityUser> _userManager;
        private readonly ILogger<IndexModel> _logger;

        public IndexModel(ILogger<IndexModel> logger, UserManager<IdentityUser> userManager)
        {
            _logger = logger;
            _userManager = userManager;
        }

        public async Task OnGet()
        {
            CultureInfo.CurrentCulture = CultureInfo.GetCultureInfo("th-TH");
            CultureInfo.CurrentUICulture = CultureInfo.GetCultureInfo("th-TH");

            var user = new IdentityUser("foo");
            var result = await _userManager.CreateAsync(user);
            if (!result.Succeeded)
                throw new Exception("Failure inserting");

            var loadedUser = await _userManager.FindByIdAsync(user.Id);
            Console.WriteLine($"Loaded user: {loadedUser.UserName}");

            result = await _userManager.DeleteAsync(loadedUser);
            if (!result.Succeeded)
                throw new Exception("Failure deleting");
        }
    }
}
