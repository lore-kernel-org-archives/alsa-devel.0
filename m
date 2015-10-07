From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Wed, 07 Oct 2015 17:31:25 +0100
Message-ID: <1665419.tJj10qIhUo@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <3067439.4bLxTPZOO7@kamdesktop>
 <alpine.DEB.2.02.1510071709440.30181@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id A33982614D3
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 18:31:27 +0200 (CEST)
Received: by wicgb1 with SMTP id gb1so219326716wic.1
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 09:31:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1510071709440.30181@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 07 Oct 2015 17:20:39 Ricard Wanderlof wrote:

> Actually, you should be able to get the configuration information directly
> in Linux by using 'lsusb -v'. It lists the 'Unknown descriptors' in their
> entirety in hex (prefixed by 'UNRECOGNIZED:') so that you can decode them
> separately without having to examine the actual binary packet content in
> Wireshark.

Yep, already done this (see my first post in this thread). I posted this as an 
example of Wireshark's decoding of the non-isochronous packets.

Cheers,

Keith
