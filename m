From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support as
	well as I2C
Date: Thu, 28 Aug 2008 14:01:05 +0100
Message-ID: <20080828130104.GD11132@sirena.org.uk>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-4-git-send-email-cooloney@kernel.org>
	<20080827110143.GB10834@sirena.org.uk>
	<386072610808272046u270c1302g1102bf1f0bd9b6ee@mail.gmail.com>
	<20080828101434.GB11132@sirena.org.uk>
	<s5h3akp9uii.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E186E103871
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 15:01:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h3akp9uii.wl%tiwai@suse.de>
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
Cc: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Cliff Cai <cliff.cai@analog.com>, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 28, 2008 at 02:47:01PM +0200, Takashi Iwai wrote:

> I still postponed to merge Jean's latest patches.  Care to check that
> don't conflict your work and send them together?

No problem from my point of view, though all I'll do is construct a
patch series with Jean's changes at the start so from that point of view
you may as well merge them directly - it doesn't change the work that
needs to be done.
