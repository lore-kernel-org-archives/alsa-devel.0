From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Fix the
 incorrect	referencing of I2SCON register
Date: Fri, 10 Jun 2011 09:26:26 +0100
Message-ID: <4DF1D532.6020201@ti.com>
References: <1307669814-9375-1-git-send-email-sbkim73@samsung.com>
	<BANLkTinPmAH5tTV737r2q2VNa-kSqNAWig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id C7B4010382F
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 10:26:34 +0200 (CEST)
In-Reply-To: <BANLkTinPmAH5tTV737r2q2VNa-kSqNAWig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 10/06/11 06:41, Jassi Brar wrote:
> On Fri, Jun 10, 2011 at 7:06 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
>> If DMA active status should be checked, I2SCON register should be referenced.
>> In this patch, Fix the incorrect referencing of I2SCON register.
>>
>> Reported-by : Lakkyung Jung <lakkyung.jung@samsung.com>
>> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> 
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> ____________________________________

Acked-by: Liam Girdwood <lrg@ti.com>
