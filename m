From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix BCLK calculation of WM8994
Date: Tue, 2 Feb 2010 11:20:59 +0000
Message-ID: <20100202112059.GG6566@rakim.wolfsonmicro.main>
References: <4B67F35D.905@samsung.com>
 <4B67F60F.4090803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEF51103826
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 12:21:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B67F60F.4090803@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: cw00.choi@samsung.com, alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 02, 2010 at 06:53:19PM +0900, Joonyoung Shim wrote:

> This fixes BCLK calculation and removes unnecessary check code.

> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Oh dear, I'm a bit surprised this tested OK for me but it did.  Thanks,
applied.
