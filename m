From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH resend v5 0/3] ASoC: cygnus: Add audio support for
 Broadcom Cygnus SoC
Date: Tue, 29 Mar 2016 12:20:25 -0700
Message-ID: <56FAD579.3060703@broadcom.com>
References: <1459277192-10942-1-git-send-email-simran.rai@broadcom.com>
 <20160329190910.GF2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329190910.GF2350@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Simran Rai <simran.rai@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Simran Rai <ssimran@broadcom.com>, Lori Hikichi <lhikichi@broadcom.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Arun Parameswaran <arunp@broadcom.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 29/03/16 12:09, Mark Brown wrote:
> On Tue, Mar 29, 2016 at 11:46:29AM -0700, Simran Rai wrote:
> 
>> Changes from v4:
>> - Fix power suspend function and add power resume function
>> - Remove clock initialization code from audio driver to clock framework
> 
> I can't find any sign of anything since your v4 having been submitted
> previously so this isn't a resend (and including noise like that in the
> subject line just means less space for content anyway).

Subject apart, and thanks for the education, is there something wrong
with this patch series?
