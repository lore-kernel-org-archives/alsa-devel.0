From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: US-1641 drivers involvment
Date: Thu, 29 Aug 2013 15:01:45 +0200
Message-ID: <521F4639.2060600@ladisch.de>
References: <CA+5WxH+L75iiV4OkXoHAZk38AG9984VLctGNKm+61nTh4P2XTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id B1A342654AB
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 15:01:53 +0200 (CEST)
In-Reply-To: <CA+5WxH+L75iiV4OkXoHAZk38AG9984VLctGNKm+61nTh4P2XTA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luca Novarini <luca.novarini@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Luca Novarini wrote:
> I'm writing you to know how can I participate in the growth of ALSA
> supported card list to include also my current USB audio card, the
> Tascam US-1641.

>       bInterfaceClass       255 Vendor Specific Class

A driver for a device with a vendor-specific protocol would require
information from the vendor (Karsten?) or reverse engineering.


Regards,
Clemens
