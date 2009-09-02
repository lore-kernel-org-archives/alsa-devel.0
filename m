From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_dummy on Centos - Redhat
Date: Wed, 02 Sep 2009 18:26:31 +0200
Message-ID: <4A9E9CB7.8040809@ladisch.de>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 88EDE24676
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 18:26:38 +0200 (CEST)
In-Reply-To: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Giovanni Maruzzelli wrote:
> ...
> So, it's a specific problem of incompatibility between snd-dummy and
> the kernel of Centos 5.2 and 5.3 (same kernels as in RHEL5).

What's the value of CONFIG_HZ in those and your kernels?


Best regards,
Clemens
