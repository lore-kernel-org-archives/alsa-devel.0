From: Fred Gleason <fredg@wava.com>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Mon, 6 Jan 2003 09:09:04 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301060909.04979.fredg@wava.com>
References: <Pine.LNX.4.33.0301051600200.500-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailbag.wava.com (root@mailbag.wava.com [207.197.206.12])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA00487
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 15:08:28 +0100
Received: from roonwit (nevrast.salemradiolabs.com [65.242.27.15])
	by mailbag.wava.com (8.11.4/8.11.4) with ESMTP id h06E8J205420
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 09:08:19 -0500
In-Reply-To: <Pine.LNX.4.33.0301051600200.500-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sunday 05 January 2003 10:05, Jaroslav Kysela wrote:

> Well, you're talking about PCM devices (subdevices are one level after
> devices):
>
> cards -> pcm devices -> pcm subdevices

What are the differences between a "device" and a "subdevice" in general?=
  Is=20
this indicative of some underlying hardware architecture, or is it a pure=
ly=20
logical/virtual artifact?

Cheers!


|------------------------------------------------------------------------=
-|
|      Frederick F. Gleason, Jr.      |         Salem Radio Labs         =
 |
|       Voice: 1-(540)-341-2880       |      87 Lee Highway, Suite 11    =
 |
|        FAX: 1-(540)-341-7176        |        Warrenton, VA 20188       =
 |
|------------------------------------------------------------------------=
-|
|    The real problem with hunting elephants is carrying the decoys.     =
 |
|                                             -- Anonymous               =
 |
|------------------------------------------------------------------------=
-|



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
