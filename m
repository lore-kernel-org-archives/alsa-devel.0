From: Gregoire Favre <greg@ulima.unil.ch>
Subject: How to put 16bit none audio PCM data stream into a 32bit none audio S/P-DIF transport stream?
Date: Tue, 8 Apr 2003 16:02:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030408140230.GA1987@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have an AC3 receiver which uses the bit flags of the S/P-DIF transport
stream for identifying none audio, and I use the cs46xx driver for my
Hercules Digifire 7.1 (under windows, using the included DVD player I
could have a real 5.1).

Under linux using ALSA, all I get is a cliking sound... does anyone know
how I could solve this (without changing my hardware of course)?

I have looked at the source, but it's far too complicated for me...

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
