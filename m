From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v4 3/4] ASoC: SAMSUNG: Modify I2S driver
 to	support idma
Date: Fri, 1 Jul 2011 15:18:53 +0100
Message-ID: <4E0DD74D.4080909@ti.com>
References: <1309484927-3950-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 829BA10380B
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 16:18:59 +0200 (CEST)
In-Reply-To: <1309484927-3950-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 01/07/11 02:48, Sangbeom Kim wrote:
> Previously, I2S driver only can support system dma.
> In this patch, i2s driver can support internal dma too.
> IDMA h/w configuration is initialized on idma.c
> 
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
