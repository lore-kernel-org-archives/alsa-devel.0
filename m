From: "Peter Heatwole" <peter599@gotnet.net>
Subject: RE: AC3 passthru intel8x0 + cs4299
Date: Mon, 24 Feb 2003 10:24:43 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a3ed0b9090984f29bcefd04788e2d3c0.peter599@gotnet.net>
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
To: alsa-devel@lists.sourceforge.net, Zierath Bernd <B.Zierath@ebv.com>, Peter Heatwole <peter599@gotnet.net>
List-Id: alsa-devel@alsa-project.org

Peter Heatwole wrote:
> I would recommend looking into setting up a mixer function

   Here's some more info of what I mean:

http://www=2Ealsa-project=2Eorg/~iwai/writing-an-alsa-driver/c765=2Ehtm



> (BTW, what would be the standard mixer name used for AC3 passthru?)

http://www=2Ealsa-project=2Eorg/~iwai/writing-an-alsa-driver/x1152=2Ehtm

   I suppose the proper answer would be "IEC958 Raw"?  This would make more =
sense
that "AC3-something" since this would apply to DTS-passthru and other forms =
of
digital output=2E


HTH,
-- Peter Heatwole
"Murphy was just a well known pessimist=2E"



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
