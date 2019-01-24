From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 6/6] ASoC: soc-core: use
 for_each_link_codecs() for dai_link codecs
Date: Thu, 24 Jan 2019 10:48:45 +0100
Message-ID: <04847b9e-71e3-a778-5cdd-cf7b14971f25@samsung.com>
References: <87imyiamj4.wl-kuninori.morimoto.gx@renesas.com>
 <CGME20190121003405epcas1p3f72eb59673abe94235326cbb24251b3d@epcas1p3.samsung.com>
 <87a7juamhi.wl-kuninori.morimoto.gx@renesas.com>
 <6e72e1ea-8879-7cab-f2d8-18da7a0a883c@samsung.com>
 <20190122173902.GE7579@sirena.org.uk>
 <87munqsrj6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DBA426756F
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 10:49:01 +0100 (CET)
In-reply-to: <87munqsrj6.wl-kuninori.morimoto.gx@renesas.com>
Content-language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

On 1/24/19 03:55, Kuninori Morimoto wrote:
> 
> Thank you for pointing it.
> 
> I hope attached v2 patch works for you.
> It is based on latest Mark branch.
> Can you test it ? If it was OK, I will re-post it.

Thank you, with that patch everything seems fine on Odroid boards
now. You can add my 

Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
