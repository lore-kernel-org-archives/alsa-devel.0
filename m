From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: S3C64XX: IISv4: Add CPU driver
Date: Wed, 5 May 2010 15:30:53 +0100
Message-ID: <20100505143046.GA9530@rakim.wolfsonmicro.main>
References: <1272351431-3981-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB2FA2473E
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 16:30:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272351431-3981-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 03:57:11PM +0900, Jassi Brar wrote:
> Add the CPU driver for the IISv4 block found on S3C6410.
> For now, the driver is almost a copy of s3c64xx-i2s.c but
> it should diverge as more IISv4 specific stuff is added.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

Actually, this is the first patch that seems to have an issue so I've
applied the patches up till this point.
