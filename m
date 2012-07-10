From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 4/4] ASoC: tlv320aic3x: add AGC settings
Date: Tue, 10 Jul 2012 11:16:22 +0200
Message-ID: <4FFBF2E6.5@aksignal.cz>
References: <1341906070-4429-1-git-send-email-jiri.prchal@aksignal.cz>
	<20120710085717.GB3918@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CB0D24987
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 11:16:24 +0200 (CEST)
In-Reply-To: <20120710085717.GB3918@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oh, sorry about that,
sending patch from git I cannot remove this numbering starting with 1 on already applied patch.
How can I fix it?

Dne 10.7.2012 10:57, Mark Brown napsal(a):
> On Tue, Jul 10, 2012 at 09:41:10AM +0200, Jiri Prchal wrote:
>> This patch adds AGC target level and times settings for TLV320AIC3x.
>> Enums uses small arrays of two channels left and right since it uses different registers.
>
> Patches 1-3 don't seem to have been sent...
>
