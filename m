From: "R. Geoffrey Newbury" <newbury@mandamus.org>
Subject: ALSA and CS4610 chipset
Date: Fri, 21 Jan 05 14:13:03 -0500
Message-ID: <20050121191310.EFND14536.tomts37-srv.bellnexxia.net@TP600>
Reply-To: "R.  Geoffrey Newbury" <newbury@mandamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sirs,

I am running Mepis (Debian-based) on a Thinkpad 600. It has the Crystal
CS4610 chipset according to lspci and other probes.
However, ALSA fails.

I attach copies of the DMESG, SYSLOG, KUDZU and LSPCI files. These are all
run with the 2.4.26 kernel: there is no difference when I install and run
the 2.6.10 kernel.

I hope that you can make something of this, and determine why I cannot get
sound from this machine under Linux (I note that my desktop machine
identifies, finds and installs properly with a Soundblaster SBLive! card.


Thanks in advance

Geoff
R. Geoffrey Newbury                          newbury@mandamus.org
Barrister and Solicitor                         Telephone: 905-271-9600                 
Mississauga,Ontario, Canada              Facsimile:   905-271-1638



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
