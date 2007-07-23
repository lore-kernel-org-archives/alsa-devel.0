From: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix Kconfig entry
	for	SND_S3C24XX_SOC_NEO1973_WM8753
Date: Mon, 23 Jul 2007 09:39:50 +0100
Message-ID: <1185179990.10153.0.camel@gg-desktop.wolfsonmicro.main>
References: <85hcnvzf9r.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EE992447F
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 10:41:05 +0200 (CEST)
In-Reply-To: <85hcnvzf9r.fsf@Orfeo.duckcorp.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, laforge@openmoko.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-07-23 at 10:38 +0200, Arnaud Patard wrote:
> SND_S3C24XX_SOC_NEO1973_WM8753 depends on MACH_GTA01 but the Kconfig
> entry which is going to be merged is MACH_NEO1973_GTA01.
> 
> signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
This one is fine by me, I was just waiting for official merge before
doing this myself.

Thanks

Graeme
