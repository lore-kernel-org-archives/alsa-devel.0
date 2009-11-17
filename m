From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 4/7] S3C64XX PCM: Added PCLK clock source
 for the PCM controllers
Date: Tue, 17 Nov 2009 11:55:46 +0000
Message-ID: <20091117115546.GB823@rakim.wolfsonmicro.main>
References: <1258444424-24087-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8A70103888
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 12:55:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258444424-24087-1-git-send-email-jassi.brar@samsung.com>
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
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 04:53:44PM +0900, Jassi Brar wrote:
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

As previously mentioned by both myself and Ben this patch should go via
Ben's tree since there is no build time dependency.  The patch itself is
OK but it should not be part of this series.
