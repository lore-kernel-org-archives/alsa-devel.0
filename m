From: prasannatsmkumar <prasannatsmkumar@gmail.com>
Subject: Fwd: Low volume with Realtek ALC 883.
Date: Thu, 20 Dec 2012 23:17:32 +0530
Message-ID: <CANc+2y7PksQHotSHBgrwWJmoCEr2ynOZ4tWiTNVzNH4yze6ZXg@mail.gmail.com>
References: <CANc+2y6O3YT9uuc1zS9FD01Kx8ws3fZsmfyvWpvGSZZk1OviPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f47.google.com (mail-ee0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C28182651EE
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 18:47:32 +0100 (CET)
Received: by mail-ee0-f47.google.com with SMTP id e51so1877187eek.6
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 09:47:32 -0800 (PST)
In-Reply-To: <CANc+2y6O3YT9uuc1zS9FD01Kx8ws3fZsmfyvWpvGSZZk1OviPQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi ALSA / pulseaudio people,

Resending this as this mail was bounced by alsa devel list.

I am having a Realtek ALC 883 chip. The sound volume is very low
compared to what I hear in windows - I maintain same speaker volume
and play same audio. If I keep the volume as 10% in windows I have to
keep a volume of at least 25+% in Linux. Is there any way to improve
it? I have been seeing such a situation for past 4 or 5 years (from
Fedora 9 period till today). I have tried several distributions
(Fedora, Vector Linux, PC Linux OS, Ubuntu, Mint) and all have the
same behaviour. Currently I am running Ubuntu 11.10 with 3.5 kernel.

$cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.25.

Should I file a bug? If so in which component (kernel or pulseaudio)?

Thanks in advance,
PrasannaKumar
