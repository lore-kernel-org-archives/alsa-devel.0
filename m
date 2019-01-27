From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: alsa-utils source is missing axfer/test/generator.h
Date: Sun, 27 Jan 2019 11:34:19 +0900
Message-ID: <20190127023419.GA7590@workstation>
References: <20190126144310.6r64l5lg4qnmwstk@toy.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 25647266A7C
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 03:34:26 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id z11so5762376pgu.0
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 18:34:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190126144310.6r64l5lg4qnmwstk@toy.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Jan 26, 2019 at 03:43:10PM +0100, Elimar Riesebieter wrote:
> downloaded
> ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.1.8.tar.bz2.
> 
> axfer/test/generator.h is missing in this tarball

Indeed. I post the PR to fix it.
https://github.com/alsa-project/alsa-utils/pull/10


Thanks

Takashi Sakamoto
