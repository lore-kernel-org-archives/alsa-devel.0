From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc multi-component: almost there!
Date: Wed, 28 Jul 2010 15:12:59 -0500
Message-ID: <4C508F4B.8090109@freescale.com>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>	
	<AANLkTikeAObgZsyRN-kWLERaOpICfpnjaidtOUfQhQwz@mail.gmail.com>
	<1280326072.3085.562.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe008.messaging.microsoft.com
	[216.32.180.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E70210382A
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 22:13:18 +0200 (CEST)
Received: from mail111-va3 (localhost.localdomain [127.0.0.1])	by
	mail111-va3-R.bigfish.com (Postfix) with ESMTP id 43F231600276	for
	<alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 20:13:13 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.243])	by
	mail111-va3.bigfish.com (Postfix) with ESMTP id 1EE59C5004C	for
	<alsa-devel@alsa-project.org>; Wed, 28 Jul 2010 20:13:13 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6SKD056017411	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 13:13:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6SKO7OI009370	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 15:24:07 -0500 (CDT)
In-Reply-To: <1280326072.3085.562.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> Oh, that one is my fault. I had tried to optimize part of the probe() a
> little and have reverted that change now.

Ok, it works now.  Thanks.
