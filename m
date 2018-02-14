From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
Date: Wed, 14 Feb 2018 16:41:54 +0200
Message-ID: <CAHp75Vey-RoLw9kWRg1mdz7-4vBcmOUmdLxjz067f3qjN_S3NA@mail.gmail.com>
References: <CAErzpmuxmrJszRz5_SZXPMkdU2UWNHChrnKjnHuCWZYrs4hgTA@mail.gmail.com>
 <20180212114937.GA12976@sirena.org.uk> <CAErzpmt+HhGkVoN199iPDmQx-1z3iS3waxYQ=oxvn14Bm0R5gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErzpmt+HhGkVoN199iPDmQx-1z3iS3waxYQ=oxvn14Bm0R5gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 14, 2018 at 4:39 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
> On Mon, Feb 12, 2018 at 7:49 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Feb 09, 2018 at 11:10:55PM +0800, Donglin Peng wrote:

> Hi Mark, do you know the way to disable gmail word wrap in plain text mode?
> I find that gmail will force to wrap word at 70 characters in plain text mode.

> There is a connection error when I use git send-email to send the patch
> because I am using VPN.

You may use SMTPS port (587 IIRC?) of Gmail to send a patch via git send-email.

-- 
With Best Regards,
Andy Shevchenko
