From: David Henningsson <david.henningsson@canonical.com>
Subject: Patch subject line (was: Re: [PATCH] asoc: bfin: use
 dev_err to print error log instead of dev_dbg)
Date: Thu, 21 Jun 2012 16:50:50 +0200
Message-ID: <4FE334CA.7090205@canonical.com>
References: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120621100841.GP4037@opensource.wolfsonmicro.com>
	<CAHG8p1ACFtV0p8c8MQFSVDuBUX0y-CTw_uXXXyPaZmHRYXZfBw@mail.gmail.com>
	<20120621104743.GT4037@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 3CEC9243C8
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 15:29:37 +0200 (CEST)
In-Reply-To: <20120621104743.GT4037@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/21/2012 12:47 PM, Mark Brown wrote:
> On Thu, Jun 21, 2012 at 06:29:40PM +0800, Scott Jiang wrote:
>> 2012/6/21 Mark Brown<broonie@opensource.wolfsonmicro.com>:
>>> On Thu, Jun 21, 2012 at 01:51:58PM -0400, Scott Jiang wrote:
>>>> Signed-off-by: Scott Jiang<scott.jiang.linux@gmail.com>
>
>>> Applied, but as I said last time you should use subject lines that match
>>> up with the rest of the subsystem.
>
>> Sorry, I'm not sure what you mean. Do you mean 80 columns or style?
>> Could you please give me more details?
>
> You're calling the subsystem "asoc" not "ASoC".

While we're at it, how about switching to the a/b/c style used by 
several other subsystems?

I personally think "alsa/hda/realtek" looks much prettier than the 
shoutier "ALSA: HDA: Realtek:" thing we have today.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
