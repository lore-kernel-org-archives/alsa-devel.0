From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: Re: KASAN: use-after-free Read in snd_pcm_timer_resolution
Date: Thu, 5 Apr 2018 16:42:41 +0000
Message-ID: <DM5PR2101MB10326C8216F954D62A720FEAFBBB0@DM5PR2101MB1032.namprd21.prod.outlook.com>
References: <s5ha7ul2u9l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5ha7ul2u9l.wl-tiwai@suse.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <Alexander.Levin@microsoft.com>, Takashi Iwai <tiwai@suse.de>Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "colin.king@canonical.com" <colin.king@canonical.com>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>"stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi.

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has also determined it's probably a bug fixing patch. (score: 98.81=
13)

The bot has tested the following trees: v4.15.15, v4.14.32, v4.9.92, v4.4.1=
26,=20

v4.15.15: Build OK!
v4.14.32: Build OK!
v4.9.92: Build OK!
v4.4.126: Build OK!

Please let us know if you'd like to have this patch included in a stable tr=
ee.
