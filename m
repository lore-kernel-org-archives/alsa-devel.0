From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add platform read and write.
Date: Mon, 4 Jul 2011 12:41:58 -0700
Message-ID: <20110704194157.GD32624@opensource.wolfsonmicro.com>
References: <1309774215-4083-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82BA6103885
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 21:42:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309774215-4083-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 11:10:15AM +0100, Liam Girdwood wrote:
> In preparation for ASoC Dynamic PCM (AKA DSP) support.
> 
> Allow platform driver to perform IO. Intended for platform DAPM.

Sorry, also meant to add at the top that I applied the patch!
