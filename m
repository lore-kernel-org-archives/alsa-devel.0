From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.35
Date: Wed, 17 Mar 2010 13:44:27 +0000
Message-ID: <20100317134426.GA10698@rakim.wolfsonmicro.main>
References: <20100316161542.GA1163@rakim.wolfsonmicro.main>
	<s5hfx3zf4j7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65859103822
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 14:44:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfx3zf4j7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 17, 2010 at 02:42:36PM +0100, Takashi Iwai wrote:

> This causes the build error:

Yes, I noticed this this morning.  I've got a patch queued waiting for
Liam's review (which I'd meant to get cherry picked over but didn't) -
it'll be with you by the end of today.

Sorry about this, once -rc2 is out and ARM actually builds my testing
will get back to normal.
