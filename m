From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v9] MIDI driver for Behringer BCD2000 USB
 device
Date: Mon, 07 Apr 2014 16:02:39 +0200
Message-ID: <5342AFFF.5070502@ladisch.de>
References: <1396636850-2765-1-git-send-email-dev@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 27F91261691
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 16:02:41 +0200 (CEST)
In-Reply-To: <1396636850-2765-1-git-send-email-dev@kicherer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Kicherer <dev@kicherer.org>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Mario Kicherer wrote:
> This patch adds initial support for the Behringer BCD2000 USB DJ controller.
> At the moment, only the MIDI part of the device is working, i.e. knobs,
> buttons and LEDs.
>
> I also plan to add support for the audio part, but I assume that this will
> require more effort than the rather simple MIDI interface. Progress can be
> tracked at https://github.com/anyc/snd-usb-bcd2000.
>
> Signed-off-by: Mario Kicherer <dev@kicherer.org>

Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
