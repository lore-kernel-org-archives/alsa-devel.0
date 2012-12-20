From: prasannatsmkumar <prasannatsmkumar@gmail.com>
Subject: Low volume with Realtek ALC 883.
Date: Thu, 20 Dec 2012 23:07:34 +0530
Message-ID: <CANc+2y6O3YT9uuc1zS9FD01Kx8ws3fZsmfyvWpvGSZZk1OviPQ@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi ALSA people,

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
