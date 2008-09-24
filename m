From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Guide to Linux Sound APIs
Date: Thu, 25 Sep 2008 00:48:33 +0200
Message-ID: <20080924224833.GA8280@tango.0pointer.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
Content-Disposition: inline
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: PulseAudio Discussion List <pulseaudio-discuss@mail.0pointer.de>
List-Id: alsa-devel@alsa-project.org

Heya!

At the audio microconf at the Linux plumbers conference one thing
became very clear: it is very difficult for programmers to figure out
which audio API to use for which purpose and which API not to use when
doing audio programming on Linux. Someone needed to sit down and write
up a small guide. And that's what I just finished doing.

I'd thus like to draw your attention to this new (long) blog story of
mine containing this guide:

http://0pointer.de/blog/projects/guide-to-sound-apis

I'd be very thankful for comments, especially from you Takashi and
Jaroslav since it contains quite some details about the "safe" subset
of the ALSA API!

I'm thankful for all kinds of input!

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
