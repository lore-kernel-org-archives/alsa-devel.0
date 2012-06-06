From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH] ASoC:isabelle:Remove regmap_exit()
Date: Wed, 6 Jun 2012 14:29:03 +0530
Message-ID: <4FCF1BD7.7090807@ti.com>
References: <1338812094-10426-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120604143557.GK7538@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id CC8E8104518
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 10:53:00 +0200 (CEST)
In-Reply-To: <20120604143557.GK7538@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Deshpande A,
	Vishwas" <Vishwas.A.Deshpande@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Monday 04 June 2012 08:05 PM, Mark Brown wrote:
> On Mon, Jun 04, 2012 at 05:44:54PM +0530, MR.Swami.Reddy@ti.com wrote:
>> From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
>>
>> ASoC:isabelle:With devm_ APIs regmap_exit() not needed, so remove regmap_exit().
> Applied, but please use a changelog style appropriate for the subsystem!

Thank you. Will take-care the changelog style appropriately in upcoming
patches.

Thanks
Swami
