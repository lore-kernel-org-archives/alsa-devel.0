From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: [lack of] dynamic detection/loading of modules
Date: Wed, 26 Feb 2003 22:58:55 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002201c2de14$8cb157e0$aa1f830a@ICO>
References: <20030227033057.BEBZ2263.mta02.fuse.net@mail08.voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030227033057.BEBZ2263.mta02.fuse.net@mail08.voicenet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Paul Davis' <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> cat /proc/modules | grep '^snd'

Thanks for the reply. A couple of questions:

Where do you put this?

How do you trigger it automatically upon connection of a hot-pluggable
hw (if the stuff is blacklisted)?

How can we make this user-friendly? (i.e. no user interaction -> plug
'n' use).

Ico



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
