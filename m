From: Brent Weatherall <brentweatherall@gmail.com>
Subject: Previous Post on PandaBoard
Date: Thu, 31 Jan 2013 09:05:10 -0800
Message-ID: <CAAo96ZD-wZCNvJtY5t3bu6MHWEexNRvuNhfssUyp-Gum1DrRmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E292615D5
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 18:05:12 +0100 (CET)
Received: by mail-pb0-f45.google.com with SMTP id rq13so1702751pbb.18
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 09:05:11 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hello,

     My previous post about PandaBoardES audio had one mistake.  The code
regarding the min/max values was a result of stepping through the
'snd_pcm_hw_params' call and NOT the 'snd_pcm_set_rate_near' call.  My
apologies for the bad information.

Thank you.

Regards,

Brent
