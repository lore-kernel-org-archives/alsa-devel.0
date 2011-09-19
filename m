From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/17] ASoC: twl6040: Cleanups and fixes
Date: Mon, 19 Sep 2011 11:12:36 +0100
Message-ID: <20110919101235.GA5467@sirena.org.uk>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A71E249A9
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 12:12:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 03:39:22PM +0300, Peter Ujfalusi wrote:

> The first four patch of this series (the MFD/Input patches) has been already
> sent to upstream to the relevant lists, but I wanted to include here as well,
> since I have dependency on that series later on.
> If it is OK with you, it would be best to merge these MFD/Input changes through
> the audio tree for 3.2.

It'd be really good if you could manage to split this stuff up - this
series is enormous and it's getting posted rather a lot, much of this
stuff seems like it could be split out and posted separately.
