From: Harald Sitter <sitter@kde.org>
Subject: Re: crashes in namehint
Date: Thu, 31 Jan 2013 17:36:54 +0100
Message-ID: <CAEc+18FVASYMumcO-r9gEZazjLa+ghCxqttK4rCiNR4wcbgs_w@mail.gmail.com>
References: <CAEc+18GnWriRtYnd+u5hiQ7OpcAytp1hakhbdZjYVzxcdTFwcQ@mail.gmail.com>
 <s5hehh1725q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f54.google.com (mail-da0-f54.google.com
 [209.85.210.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C5E22615D5
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 17:37:15 +0100 (CET)
Received: by mail-da0-f54.google.com with SMTP id n2so1364642dad.41
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 08:37:15 -0800 (PST)
In-Reply-To: <s5hehh1725q.wl%tiwai@suse.de>
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
Cc: colin@mageia.org, Martin Sandsmark <sandsmark@samfundet.no>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 31, 2013 at 5:22 PM, Takashi Iwai <tiwai@suse.de> wrote:

> Right now we fixed snd_device_name_hint() to be reentrant, so it's
> worth to check whether the latest git works for you...
>

still seeing the same behavior with master unfortunately.

HS
