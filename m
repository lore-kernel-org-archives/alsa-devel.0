From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: Latest CVS ALSA: XMMS 1.2.10 now crashes after
 running aplay
Date: Tue, 01 Feb 2005 11:08:29 +0100
Message-ID: <m27jls8uea.fsf@vador.mandrakesoft.com>
References: <20050131205136.3456.qmail@web52906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050131205136.3456.qmail@web52906.mail.yahoo.com> (Chris
 Rankin's message of "Mon, 31 Jan 2005 20:51:35 +0000 (GMT)")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Chris Rankin <rankincj@yahoo.com> writes:

> I have just upgraded my alsa drivers, library and utilities to the
> latest CVS version, and have just discovered that xmms 1.2.10 now
> crashes whenever I play a WAV file using aplay. I was playing a CD
> through xmms at the time.
> 
> I have an Audigy 2 soundcard, and a dual P4 Xeon machine. I am
> attaching an strace from xmms, and am also raising this issue with
> the xmms people.

Takashi Iwai has wrote a patch for xmms that works smoothly, you may
want to port it to current xmms CVS



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
