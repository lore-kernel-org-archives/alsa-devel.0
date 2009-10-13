From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: S3C: Remove <plat/audio.h>
Date: Tue, 13 Oct 2009 13:35:30 +0100
Message-ID: <20091013123529.GB11977@rakim.wolfsonmicro.main>
References: <20091012201708.930764863@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D93541038F1
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 14:35:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20091012201708.930764863@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben@simtec.co.uk>
Cc: alsa-devel@alsa-project.org, Simtec Linux Team <linux@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 09:17:09PM +0100, Ben Dooks wrote:
> Remove the <plat/audio.h> include from arch/arm/plat-s3c/include/plat/audio.h
> as it provides nothing to the current kernel and is not in any future plans
> for the system.

> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
> Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

Applied, thanks.
