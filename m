From: Daniel Mack <zonque@gmail.com>
Subject: Re: XMOS UAC2
Date: Thu, 09 Aug 2012 21:45:34 +0200
Message-ID: <5024135E.3000900@gmail.com>
References: <50241074.8050001@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B3FB326635B
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 21:15:51 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so288329bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 09 Aug 2012 12:45:37 -0700 (PDT)
In-Reply-To: <50241074.8050001@freemail.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: adelias <adelias@freemail.gr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09.08.2012 21:33, adelias wrote:
> I have an XMOS Reference board with the latest firmware (v3.3). With 
> ALSA 1.0.23 it enumerates and functions properly. With ALSA 1.0.25 it 
> appears to enumerate properly after boot up but will not output sound. 
> Removing and reinserting snd-usb-audio with modprobe doesn't help. Only 
> after I reset it by unpluging and repluging the usb cable will it 
> function as it should.

Could you provide the full boot logs of both scenarios please?


Daniel
