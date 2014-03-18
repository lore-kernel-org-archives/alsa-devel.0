From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs42888: Add codec driver support
Date: Tue, 18 Mar 2014 14:55:03 -0500
Message-ID: <alpine.DEB.2.02.1403181454470.14838@heelrod>
References: <1394538091-19513-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140318131033.GC11706@sirena.org.uk>
 <alpine.DEB.2.02.1403180936200.14838@heelrod>
 <alpine.DEB.2.00.1403181202310.7177@phandrigan-desktop>
 <20140318195159.GQ11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0062.outbound.protection.outlook.com [207.46.100.62])
 by alsa0.perex.cz (Postfix) with ESMTP id ABBD926167E
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 20:54:55 +0100 (CET)
In-Reply-To: <20140318195159.GQ11706@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, lars@metafoo.de, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, Paul Handrigan <paul.handrigan@cirrus.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rob@landley.net, Nicolin Chen <Guangyu.Chen@freescale.com>, grant.likely@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Tue, 18 Mar 2014, Mark Brown wrote:

> On Tue, Mar 18, 2014 at 12:08:02PM -0500, Paul Handrigan wrote:
>> On Tue, 18 Mar 2014, Brian Austin wrote:
>
>>> Driver looks good to me. I think we should name it the cs42xx8 since this
>>> actually covers CS42448 and CS42888. The CS42888 is derived from the
>>> CS42448.
>
>> V3 looks good. As Brian said, the name should be changed to cs42xx8.
>
> Great, so if Nicolin resubmits with the rename when he gets back he can
> add acks from both of you?  The driver looked fine to me too.
>
Yes sir
