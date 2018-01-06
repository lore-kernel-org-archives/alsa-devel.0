From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 2/3] gpio: merrifield: Add support of ACPI enabled
 platforms
Date: Sat, 6 Jan 2018 11:32:48 +0200
Message-ID: <20180106093248.GE27654@lahna.fi.intel.com>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com>
 <20180105160935.48588-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105160935.48588-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 05, 2018 at 06:09:34PM +0200, Andy Shevchenko wrote:
> The driver needs the pin control device name for ACPI.
> 
> We are looking through ACPI namespace and return first found device
> based on ACPI HID for Intel Merrifield FLIS (pin control device).
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
