From: Fred Gleason <fredg@wava.com>
Subject: Re: PCM API questions
Date: Mon, 24 Jun 2002 11:18:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206241118.37216.fredg@wava.com>
References: <200206241415.g5OEFkf09744@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200206241415.g5OEFkf09744@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>, Takashi Iwai <tiwai@suse.de>
Cc: Joshua Haberman <joshua@haberman.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 24 June 2002 10:17, Paul Davis wrote:
> >the names above are not defined on all cards (except for default).
> >i think we need a kind of config database for each card.
> >this is useful not only for pcm but also for parsing the mixer
> >structure.
>
> i think this is the wrong solution. i believe the correct solution is
> to provide a **simple** way to get every defined PCM device name.

Amen!  I understand the need for flexibility in configuring devices, but =
this=20
is a routine requirement that IMHO is currently vastly more complex to=20
implement than it needs to be.

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
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
