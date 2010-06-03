From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] AsoC/s3c: patch for the unnecessary
 variable 'state' removal
Date: Thu, 3 Jun 2010 17:53:30 +0100
Message-ID: <20100603165330.GF2762@rakim.wolfsonmicro.main>
References: <4C068CE3.8060107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3833103AE2
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 18:53:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C068CE3.8060107@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, jassi.brar@samsung.com, Ben Dooks <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 12:54:59AM +0800, Wan ZongShun wrote:
> The variable 'state' of structure 's3c_ac97_info' seems no use here,
> so this patch is to remove the unnecessary variable.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

Applied, thanks.
