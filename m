From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
	to	snd_soc_pcm_stream
Date: Sat, 20 Mar 2010 16:14:29 +0000
Message-ID: <20100320161428.GA1125@opensource.wolfsonmicro.com>
References: <20100320153022.GA32428@opensource.wolfsonmicro.com>
	<1269099560-29711-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E5D39244E5
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 17:14:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269099560-29711-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 20, 2010 at 04:39:20PM +0100, Daniel Mack wrote:

> This is a backported version for 2.6.34.

You really should say this a little more obviously as part of the
changelog, preferably referencing the master commit as well.
