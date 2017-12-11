From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Re-order some code to silence a
 warning
Date: Mon, 11 Dec 2017 13:54:03 +0200
Message-ID: <1512993243.25007.592.camel@linux.intel.com>
References: <20171208115425.rqclgmhcph5gn47j@mwanda>
         <1512991223.25007.590.camel@linux.intel.com>
         <20171211113345.ubl7rj7ftt62ox5s@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171211113345.ubl7rj7ftt62ox5s@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jani Nikula <jani.nikula@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-12-11 at 14:33 +0300, Dan Carpenter wrote:
> On Mon, Dec 11, 2017 at 01:20:23PM +0200, Andy Shevchenko wrote:
> > On Fri, 2017-12-08 at 14:54 +0300, Dan Carpenter wrote:
> > > 
> 


> I didn't like the way the code was written either but it's impossible
> to know how much change people are going to accept.  Even though I
> think
> that extra parenthesis shouldn't have been there, the original author
> felt they helped, so I try to be accomodating...
> 
> Anyway, I can resend.

Since Vinod ACKed this change, I'm fine with it.
Consider my comment as JFYI.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
