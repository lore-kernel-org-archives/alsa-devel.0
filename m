From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] ASoC updates for 2.6.36
Date: Mon, 2 Aug 2010 11:33:33 +0100
Message-ID: <24C97B09-0B9B-4115-82DF-0528B6B55EE6@opensource.wolfsonmicro.com>
References: <1280742830.3095.33.camel@odin> <s5hpqy1nx00.wl%tiwai@suse.de>
	<1280745056.3095.46.camel@odin>
	(sfid-20100802_113104_404663_A6E58875)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94DDE24480
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 12:33:35 +0200 (CEST)
In-Reply-To: <1280745056.3095.46.camel@odin>
	(sfid-20100802_113104_404663_A6E58875)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2 Aug 2010, at 11:30, Liam Girdwood wrote:

> Ok, the multi-component branch does touch arch quite a bit as we are
> adding platform devices for all our components. So it's probably safer
> for merging (after your pull request) in the for 2.6.37 period to reduce
> any merge conflict with arch.

> Fwiw, the release yesterday did take me a little by surprise as I was at
> least expecting an rc7 and a little extra time for multi-comp ;)

In that case I guess I'll send a pull request with WM8741 tomorrow and send you the multi-component updates for it separately if that's OK with you (I'm about to crash, just got in from 16 hours of flying)?
