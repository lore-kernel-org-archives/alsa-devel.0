From: Dongjiu Geng <djgeng@marvell.com>
Subject: Re: [pulseaudio] module-alsa-card.c: Failed to
 find a working profile.
Date: Fri, 19 Oct 2012 02:33:37 -0700
Message-ID: <78895A20B3CF7D49B5589B604D36692B1A8D3CEEEE@SC-VEXCH4.marvell.com>
References: <78895A20B3CF7D49B5589B604D36692B1A8D3CEEEB@SC-VEXCH4.marvell.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <78895A20B3CF7D49B5589B604D36692B1A8D3CEEEB@SC-VEXCH4.marvell.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: Dongjiu Geng <djgeng@marvell.com>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

paste the detailed log,  I am indeed what should do about that,  Thank you in advance.

Hi all:
    when I run the pulseaudio, it always shows the bellowing error log:
     01-02 09:47:27.492  1449  1449 I /system/bin/pulseaudio: E: [pulseaudio] module-alsa-card.c: Failed to find a working profile.
     01-02 09:47:27.492  1449  1449 I /system/bin/pulseaudio: E: [pulseaudio] module.c: Failed to load module "module-alsa-card" (argument: "device_id=0"): initialization failed.
     01-02 09:47:27.500  1449  1449 I /system/bin/pulseaudio: E: [pulseaudio] main.c: Module load failed.
     01-02 09:47:27.500  1449  1449 I /system/bin/pulseaudio: E: [pulseaudio] main.c: Failed to initialize daemon.
     01-02 09:47:27.500  1449  1449 I logwrapper: /system/bin/pulseaudio terminated by exit(1)

    Could you hep me ?  


Best regards,
Dongjiu Geng
