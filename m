From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: [PATCH] alsa-tools: us428control enhancements
Date: Sat, 8 Sep 2007 15:44:47 -0600
Message-ID: <8e4fc8270709081444u5d6bc795t586890bdb413ae5a@mail.gmail.com>
References: <8e4fc8270709071518s33f50be3j7908e5de5702a6c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 29C46103824
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Sep 2007 23:44:48 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so855489fka
	for <alsa-devel@alsa-project.org>; Sat, 08 Sep 2007 14:44:47 -0700 (PDT)
In-Reply-To: <8e4fc8270709071518s33f50be3j7908e5de5702a6c9@mail.gmail.com>
Content-Disposition: inline
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

On 9/7/07, Michael Bourgeous <sts.nitrogen@gmail.com> wrote:
> Hello,
>
> Here's a patch against us428control in the latest alsa-tools that adds
> the following enhancements:
.
.
> - Input Monitor pan knob now requires 1 revolution instead of 10 to
> pan from left to right, like in Windows


Note: a correction is required to this patch: the left and right pan
values are reversed.  Any feedback on the general usefulness of the
patch is welcome.

Mike Bourgeous
