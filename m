From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Status of ALSA documentation?
Date: Wed, 13 Feb 2002 10:12:58 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202131009360.623-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <XFMail.020213093941.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Feb 2002, Guenther Sohler wrote:

> > Yes and no. Just like code, there's always room for improvement. Anyway,
> > almost all functions are already documented, see:
> >
> > http://www.alsa-project.org/alsa-doc/alsa-lib/index.html
> >
> As I see, just the pcm functions are documented but the functions about midi
> and about sequencer are much more impotant. they are not there.
> I have seen documentation about 0.5.x for alsa and they are documented there,
> but the functions have changed too much to be able to use it.
> Where can I find the latest documetnation on midi and sequencer for alsa ?

They will be available when someone (probably my and Takashi's hands)
write it.  There are no many changes in principles for these interfaces.
The main difference is that the access to most data structures goes via
functions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
