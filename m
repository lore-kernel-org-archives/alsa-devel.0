From: Andreas Stahl <s9327283@inf.tu-dresden.de>
Subject: Soundcard Matrix: SEKD -> Marian
Date: Wed, 26 Nov 2003 00:47:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311260047.08904.s9327283@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi

I wanted to propose a change in the alsa soundcard Matrix: The Company known 
as SEK'D was acquired by Magix and took down its audio hardware product line. 
The Interfaces are now sold by SEK'Ds former production company called 
MARIAN:

ww.marian.de

this results in a name change for the SEK'D Siena, which is now called "Marc 8 
Midi" to fit into the marian product line. Similarly, all the other SEK'D 
cards, namely the ARC and Prodif Series are now sold by Marian keeping their 
old name.

Also I wanted to provide additional information about the Marc 8 Midi (SEK'D 
Siena): 

the Card uses 4 AKM AK4524 Converters, there is an PLX PCI 9050 target chip on 
there,  3 memory chips (2 by EliteMT and one by Winbond) and a Xilinx Spartan 
FPGA. These are the main components I could make out. I hope that is enough 
information for you to replace that question mark in the Siena row, and maybe 
even for a skilled person to write a driver ;-).
Are there similar cards with existing alsa drivers?

Thank You

Andreas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
