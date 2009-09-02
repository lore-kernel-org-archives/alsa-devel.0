From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Wed, 2 Sep 2009 18:33:59 +0200
Message-ID: <7c5010d60909020933n47381069uacadd656aa98e8e8@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<4A9E9CB7.8040809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 26C7A10389A
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Sep 2009 18:34:08 +0200 (CEST)
Received: by fxm3 with SMTP id 3so950397fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 02 Sep 2009 09:34:07 -0700 (PDT)
In-Reply-To: <4A9E9CB7.8040809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In centos is 1000HZ, in the kernels I compiled is 100HZ

On Wed, Sep 2, 2009 at 6:26 PM, Clemens Ladisch<clemens@ladisch.de> wrote:
> Giovanni Maruzzelli wrote:
>> ...
>> So, it's a specific problem of incompatibility between snd-dummy and
>> the kernel of Centos 5.2 and 5.3 (same kernels as in RHEL5).
>
> What's the value of CONFIG_HZ in those and your kernels?
>
>
> Best regards,
> Clemens
>
