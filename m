From: "Peter Heatwole" <peter599@gotnet.net>
Subject: RE: AC3 passthru intel8x0 + cs4299
Date: Tue, 25 Feb 2003 21:23:09 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <9c96cf3f389541f08bbe76a0907df1fb.peter599@gotnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Zierath Bernd <B.Zierath@ebv.com>
List-Id: alsa-devel@alsa-project.org

Peter Heatwole wrote:
> Peter Heatwole wrote:
> > I would recommend looking into setting up a mixer function

   First off, I apologize for replying to my own reply to myself=2E

   But, for those of you that may be following this thread, I would like to =
revoke
that other statement=2E  Apparently things have changed since I last had tim=
e to
check on the cs46xx driver, which is where I got the idea for a mixer contro=
l to
enable/disable IEC958 passthru=2E  It seems that a more refined method is cu=
rrently
in use, in which the software requests iec958 passthru (correct?), which def=
initely
seems to be a better choice=2E


-- Peter Heatwole
"Murphy was just a well known pessimist=2E"



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
