From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Broken pipe mystery
Date: Sat, 8 Feb 2003 12:13:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0302081212550.32024-100000@mailserver.intern.bfad.de>
References: <058801c2cf5b$d4f1dfb0$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <058801c2cf5b$d4f1dfb0$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 8 Feb 2003, Pete Barnard wrote:

> I have written a simple capture program which reads interleaved samples from
> the sound card and goes around in a continuous while(1) loop.  My program
> works perfectly - until it crashes after several hours with the message:

Does it always crash after the same time?

What sampling frequency do you use (kHz) ?

Best regards,
--
Tomek



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
